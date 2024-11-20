from pydantic import BaseModel
from typing import Annotated
from pydantic import BaseModel, StringConstraints
from util.generer_uuider import generer_uuid_med_delay
from dataklasser.Svaralternativ import Svaralternativ


class Spørsmål(BaseModel):
    id: Annotated[str, StringConstraints(min_length=36, max_length=36)] = (
        generer_uuid_med_delay()
    )
    tekst: str
    flervalg: bool = False
    svaralternativer: list[Svaralternativ]
