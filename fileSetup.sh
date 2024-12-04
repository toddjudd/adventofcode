# in the provided directory.
# create 25 subdirectories in the provided directory each numbered 01 to 25
# each with a file named data.txt and a file names solution.rb and a file names solution.ts

base_dir=$1

# if no base directory is provided, use the current directory
if [ -z "$base_dir" ]; then
  base_dir=$(pwd)
fi

# if the provided directory does not exist, create it
if [ ! -d "$base_dir" ]; then
  mkdir -p $base_dir
fi

# set path for copying template files ./templates
template_dir=$(pwd)/templates

# create 25 subdirectories and the files
for i in {1..25}
do
  dir_name=$(printf "%02d" $i)
  dir_path=$base_dir/$dir_name

  # create the directory
  mkdir -p $dir_path

  # create the files
  touch $dir_path/data.txt

  # copy the template files to the directory
  cp $template_dir/solution.rb $dir_path
  cp $template_dir/solution.ts $dir_path

  # replace #DAY with the day number
  sed -i '' "s/#DAY/$i/g" $dir_path/solution.rb
done
