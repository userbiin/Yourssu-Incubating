# uvicorn main:app --reload --host 0.0.0.0 --port 8000

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import httpx
import xmltodict
import asyncio

app = FastAPI(title="Classic Concert Proxy")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

SERVICE_KEY = "49f90410cfbc4d99a845e2d9733498e7"
LIST_URL = "http://www.kopis.or.kr/openApi/restful/pblprfr"
DETAIL_URL = "http://www.kopis.or.kr/openApi/restful/pblprfr"
GENRE_CLASSIC = "CCCA"


class Concert(BaseModel):
    id: str
    name: str
    startDate: str
    endDate: str
    place: str
    posterURL: str
    area: str
    genre: str
    state: str
    program: str = ""


class ConcertListResponse(BaseModel):
    count: int
    concerts: list[Concert]


def _to_list(rows):
    if rows is None:
        return []
    return [rows] if isinstance(rows, dict) else rows


async def _fetch_detail(client, mt20id):
    try:
        r = await client.get(f"{DETAIL_URL}/{mt20id}", params={"service": SERVICE_KEY})
        d = xmltodict.parse(r.text).get("dbs", {}).get("db", {})
    except Exception:
        return "", ""
    sty = d.get("sty", "") or ""
    search_text = " ".join(p for p in [sty, d.get("prfcast",""), d.get("prfcrew","")] if p)
    return sty, search_text 


@app.get("/classic", response_model=ConcertListResponse)
async def get_classic_concerts(stdate: str, eddate: str, keyword: str | None = None):
    params = {"service": SERVICE_KEY, "stdate": stdate, "eddate": eddate,
              "cpage": 1, "rows": 100, "shcate": GENRE_CLASSIC}

    async with httpx.AsyncClient(timeout=20.0) as client:
        resp = await client.get(LIST_URL, params=params)
        if resp.status_code != 200:
            raise HTTPException(502, f"KOPIS 상태코드 {resp.status_code}")
        rows = _to_list(xmltodict.parse(resp.text).get("dbs", {}).get("db"))

        base = [(row.get("mt20id",""), row) for row in rows]

        sem = asyncio.Semaphore(8)
        async def build(mt20id, row):
            async with sem:
                sty, search_text = await _fetch_detail(client, mt20id)
            if keyword and keyword.lower() not in (row.get("prfnm","") + " " + search_text).lower():
                return None
            return Concert(
                id=mt20id, name=row.get("prfnm",""),
                startDate=row.get("prfpdfrom",""), endDate=row.get("prfpdto",""),
                place=row.get("fcltynm",""), posterURL=row.get("poster",""),
                area=row.get("area",""), genre=row.get("genrenm",""),
                state=row.get("prfstate",""),
                program=sty[:60]) 

        results = await asyncio.gather(*[build(i, r) for i, r in base])
        concerts = [c for c in results if c is not None]

    return ConcertListResponse(count=len(concerts), concerts=concerts)


@app.get("/")
def root():
    return {"status": "ok", "message": "running"}