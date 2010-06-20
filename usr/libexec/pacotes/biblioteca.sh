# Atualiza as informações sobre os pacotes dos repositorios
function atualizar()
{
  for repositorio in $REPOSITORIOS; do
    Nome_repositorio=`echo $repositorio | cut -f1 -d '%'`
    endereco_repositorio=`echo $repositorio | cut -f2 -d '%'`

    if [ ! -e $DIRTRABALHO/$Nome_repositorio ]; then
      mkdir $DIRTRABALHO/$Nome_repositorio
    fi

    cd $DIRTRABALHO/$Nome_repositorio
    for arquivo in $ARQUIVOS; do
      wget -c $endereco_repositorio/$arquivo
    done
  done
}

# Formata o arquivo MANIFEST
function formatar_MANIFEST()
{
  for MANIFEST in `find $DIRTRABALHO | grep 'MANIFEST'`; do
    repositorio=`echo $MANIFEST | rev | cut -d/ -f2 | rev`

    if [ -e ${DIRTRABALHO}/${repositorio}/filelist ]; then
      rm -fr ${DIRTRABALHO}/${repositorio}/filelist
    fi

    echo "Formatando o arquivo MANIFEST.bz2 do repositorio: $repositorio"
    bunzip2 -c $MANIFEST | awk -f /usr/libexec/slackpkg/filelist.awk >> ${DIRTRABALHO}/${repositorio}/filelist

  done
}

# Verifica a assinatura GPG do pacote/arquivo
function verifica_gpg()
{
  gpg --verify ${1}.asc ${1} 2>/dev/null && echo "1" || echo "0"
}

# Retorna o endereço do pacote
function pesquisa_pacote()
{
  for FILILIST in `find $DIRTRABALHO | grep 'FILELIST.TXT'`; do
    linhas=`egrep "$1.*(tgz|txz)$" $FILILIST | awk '{print $8}'`
    if [ "$linhas" != "" ]; then
      repositorio=`echo $FILILIST | rev | cut -d/ -f2 | rev`
      endereco=`grep $repositorio $CONF/repositorio | cut -d '%' -f2`
      for i in $linhas; do
	pacote=`echo $i | sed 's/^\.//'`
	echo $endereco$pacote
      done
    fi
  done
}

# Retorna o pacote referente ao arquivo
function pesquisa_arquivo()
{
  for filelist in `find $DIRTRABALHO | grep 'filelist'`; do
    linhas=`egrep "$1" $filelist | awk '{print $1}'`
    if [ "$linhas" != "" ]; then
      repositorio=`echo $filelist | rev | cut -d/ -f2 | rev`
      endereco=`grep $repositorio $CONF/repositorio | cut -d '%' -f2`
      for i in $linhas; do
	pacote=`echo $i | sed 's/^\.//'`
	echo ${endereco}${pacote}
      done
    fi
  done
}