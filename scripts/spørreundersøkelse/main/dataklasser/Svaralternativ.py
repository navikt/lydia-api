from pydantic import BaseModel
from typing import Annotated
from pydantic import BaseModel, StringConstraints
from main.util.generer_uuider import generer_uuid_med_delay


class Svaralternativ(BaseModel):
    id: Annotated[str, StringConstraints(min_length=36, max_length=36)]
    tekst: str


def lagSvaralternativer(alternativer: list[str]) -> list[Svaralternativ]:
    return [
        Svaralternativ(id=generer_uuid_med_delay(), tekst=alternativ)
        for alternativ in alternativer
    ]
