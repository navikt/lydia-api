data class NæringSykefravær (
    val kvartal : Int,
    val sykefraversprosent : Double,
    val muligeDagsverk : Double,
    val arstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class Næring5SifferSykefravær (
    val kvartal : Int,
    val sykefraversprosent : Double,
    val muligeDagsverk : Double,
    val arstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class VirksomhetSykefravær (
    val kvartal : Int,
    val sykefraversprosent : Double,
    val muligeDagsverk : Double,
    val arstall : Int,
    val antallPersoner : Double,
    val orgnr : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class LandSykefravær (
    val kvartal : Int,
    val sykefraversprosent : Double,
    val muligeDagsverk : Double,
    val arstall : Int,
    val kode : String,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class SektorSykefravær (
    val kvartal : Int,
    val sykefraversprosent : Double,
    val muligeDagsverk : Double,
    val arstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class SykefraversstatistikkImportDto (
    val næringSykefravær : NæringSykefravær,
    val næring5SifferSykefravær: List<Næring5SifferSykefravær>,
    val virksomhetSykefravær : VirksomhetSykefravær,
    val landSykefravær : LandSykefravær,
    val sektorSykefravær : SektorSykefravær
)

data class Key (
    val kvartal : Int,
    val arstall : Int,
    val orgnr : String
)

data class SykefraversstatistikkKafkaMelding (
    val value : SykefraversstatistikkImportDto,
    val key : Key
)
