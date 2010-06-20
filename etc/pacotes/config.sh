# Arquivo de configuração do pacotes

# Configura aonde os pacotes vão ficar
CACHE=$RAIZ/var/cache/packages

# Diretorio de trabalho
DIRTRABALHO=$RAIZ/var/lib/pacotes

# Lista dos repositorios usados
REPOSITORIOS=`cat $CONF/repositorio`

# Versão do Slackware
#VERSAO_SLACKWARE="slackware64-13.1" 

ARQUIVOS="CHECKSUMS.md5 FILE_LIST FILELIST.TXT PACKAGES.TXT MANIFEST.bz2"