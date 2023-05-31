#!/bin/sh

F1SIM_HOME=$(dirname $0 | xargs -I {} realpath {} | rev | cut -d '/' -f 2- | rev)
cd $F1SIM_HOME

print_usage()
{
    echo ""
    echo " setup_env.sh [-f] [-h]"
    echo ""
    echo " -f: force"
    echo " -h: this help"
    echo ""
}

while getopts 'fh' flag; do
  case "${flag}" in
    f) FORCE='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [ -e "f1env.sh" ]
then
    echo "f1env.sh found"
    if [ "${FORCE}" != "true" ]
    then 
        while true
        do
            read -p "Continue (Y/N): " next
            case $next in 
                 [yY] ) 
                      break;;
                 [nN] )
                      exit;;
                 * ) echo invalid response;;
            esac
        done
    fi
    current_time=`date +"%Y%m%d%H%M"`
    mv f1env.sh f1env.sh.${current_time}
fi

F1SIM_HOME_ESC=$(echo $F1SIM_HOME | sed 's_/_\\/_g')

cp f1env.sh.template f1env.sh
sed -i "s/<F1SIM_HOME>/${F1SIM_HOME_ESC}/g" f1env.sh

echo "f1env.sh is configured."
echo "Set environment: source ./f1env.sh"

echo "Setting up python virtual environment"
PYTHON_VERSION=`python3 --version | cut -d ' ' -f 2 | cut -d '.' -f 1-2`
if [ $(echo "${PYTHON_VERSION} >= 3.9" | bc) -eq 1 ]
then
    python3 -m venv dev
else
    read -p "installed python version: " pyver
    python${pyver} --version
    if [ $? -eq 127 ]
    then
        echo "python${pyver} not installed. install first and then run:"
        echo ""
        echo "python${pyver} -m venv dev"
        echo ". dev/bin/activate"
        echo "pip3 install -r requirements.txt"
        echo ""
	exit 255
    fi
    python${pyver} -m venv dev
fi

. dev/bin/activate
pip3 install -r requirements.txt

echo "Python modules are configured."
echo "Set virtual environment: source dev/bin/activate"
