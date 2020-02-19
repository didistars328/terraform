#!/bin/bash
folder=project/prod
diff="$(git diff HEAD^ --name-only --diff-filter=ACMR "$folder")"
echo $diff
if [ ! -z "$diff" ]
then
    echo "It works"
else
      echo "Doesn't work"
fi