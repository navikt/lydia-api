from util.generer_uuider import generer_uuid_med_delay


class Svaralternativ:
    def __init__(self, tekst: str):
        self.id = generer_uuid_med_delay()
        self.tekst = tekst
