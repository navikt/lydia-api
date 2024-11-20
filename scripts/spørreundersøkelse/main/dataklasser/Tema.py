from typing import Literal
from pydantic import BaseModel
from dataklasser.Spørsmål import Spørsmål


class Tema(BaseModel):
    id: int
    navn: Literal["Partssamarbeid", "Sykefraværsarbeid", "Arbeidsmiljø"]
    rekkefølge: int
    type: Literal["Behovsvurdering", "Evaluering"]
    spørsmål: list[Spørsmål]
