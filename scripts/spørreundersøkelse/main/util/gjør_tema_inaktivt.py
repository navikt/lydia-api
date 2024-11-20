def gjør_tema_inaktivt(temaId: int):
    sql_fil = (
        "UPDATE ia_sak_kartlegging_tema"
        + "\n"
        + "SET status = 'INAKTIV'"
        + "\n"
        + "WHERE tema_id = "
        + str(temaId)
        + ";"
    )
    return sql_fil
