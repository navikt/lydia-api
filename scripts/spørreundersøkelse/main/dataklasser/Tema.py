from typing import Literal
from pydantic import BaseModel
from main.dataklasser.Undertema import Undertema


class Tema(BaseModel):
    id: int
    navn: Literal["Partssamarbeid", "Sykefraværsarbeid", "Arbeidsmiljø"]
    rekkefølge: int
    type: Literal["Behovsvurdering", "Evaluering"]
    undertemaer: list[Undertema]
