
HOME_DIR=~
PC_SETUP_DIR=~/igorba/git/setup


if [ -d $PC_SETUP_DIR ]; then
	export IGOR_SETUP_DIR=$PC_SETUP_DIR
fi

if ! grep -Fxq '#igor' ${HOME_DIR}/.bashrc; then
	echo "" >> ${HOME_DIR}/.bashrc
	echo "#igor" >> ${HOME_DIR}/.bashrc
	echo "if [ -d ${TARGET_HOME_DIR} ]; then" >> ${HOME_DIR}/.bashrc
	echo "	export IGOR_SETUP_DIR=${TARGET_SETUP_DIR}" >> ${HOME_DIR}/.bashrc
	echo "	export TARGET=1" >> ${HOME_DIR}/.bashrc
	echo "elif [ -d ${PC_SETUP_DIR} ]; then" >> ${HOME_DIR}/.bashrc
	echo "	export IGOR_SETUP_DIR=${PC_SETUP_DIR}" >> ${HOME_DIR}/.bashrc
	echo "fi" >> ${HOME_DIR}/.bashrc
	echo '[ -d ${IGOR_SETUP_DIR} ] && . ${IGOR_SETUP_DIR}/config/bash_config.sh' >> ${HOME_DIR}/.bashrc
fi

[ -d ${IGOR_SETUP_DIR} ] && . ${IGOR_SETUP_DIR}/config/bash_config.sh
