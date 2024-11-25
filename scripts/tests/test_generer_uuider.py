from util.generer_uuider import generer_uuider


def test_generer_uuider():
    sortert_liste_med_uuider = generer_uuider(100)

    for i in range(len(sortert_liste_med_uuider) - 1):
        # sjekk at alle er i sortert rekkefølge
        assert sortert_liste_med_uuider[i] < sortert_liste_med_uuider[i + 1]


def test_generer_uuider_første_13_tegn():
    sortert_liste_med_uuider = generer_uuider(100)

    for i in range(len(sortert_liste_med_uuider) - 1):
        # sjekk at alle er i sortert rekkefølge
        assert sortert_liste_med_uuider[i][:13] < sortert_liste_med_uuider[i + 1][:13]
