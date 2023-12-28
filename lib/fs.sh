directory_exists() {
	if [[ $# != 1 ]]; then
		echo "directory_exists() requires 1 argument"
		echo "usage: directory_exists /some/dir"
		return 1
	fi
	
	local dir=$1

	if [ -d $dir ]; then
		return 0
	else
		return 1
	fi
}

copy_directory(){
	if [[ $# != 1 ]]; then
		echo "copy_directory() requires 2 arguments"
		echo "usage: copy_directory /source/dir /destination/dir"
		return 1
	fi

	local source_directory=$1
	local destination_directory=$2

	cp -r $source_directory $destination_directory
}
