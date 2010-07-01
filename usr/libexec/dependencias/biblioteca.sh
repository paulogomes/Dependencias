# Atualiza as informações sobre os pacotes dos repositorios
function atualizar()
{
  for repositorio in $REPOSITORIOS; do
    Nome_repositorio=`echo $repositorio | cut -f1 -d '%'`
    endereco_repositorio=`echo $repositorio | cut -f2 -d '%'`

    if [ ! -e $DIRTRABALHO/$Nome_repositorio ]; then
      mkdir -p $DIRTRABALHO/$Nome_repositorio
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
  for MANIFEST in `find $DIRTRABALHO | grep 'MANIFEST.bz2'`; do
    repositorio=`echo $MANIFEST | rev | cut -d/ -f2 | rev`

    echo "Formatando o arquivo MANIFEST.bz2 do repositorio: $repositorio"
    bunzip2 -c $MANIFEST | sed -n '/[^\/\|\=]$\|^$/p' | sed 's/.*\///' | tr '\n' ' ' | sed 's/   /\n/g' > ${DIRTRABALHO}/${repositorio}/filelist
  done
}

# Retorna o pacote referente ao arquivo
function pesquisar()
{
  for filelist in `find $DIRTRABALHO | grep 'filelist'`; do
    linhas=`grep "$1" $filelist | awk '{print $1}'`
    if [ "$linhas" != "" ]; then
      echo $linhas
    fi
   done
}

function dependencia()
{
  dependencias=`ldd $(which $1) | grep 'not found' | cut -d. -f1`

  for dependencia in $dependencias;
  do
    echo $(pesquisar $i)
  done
}