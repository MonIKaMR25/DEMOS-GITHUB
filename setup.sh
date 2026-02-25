#!/bin/bash

TOKEN="$1"
ORG="Alumnos-CF"
REPO="repo-live-$(date +%s)"

curl -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -d "{\"name\":\"$REPO\", \"private\":false}" \
  https://api.github.com/orgs/$ORG/repos

echo "Repo creado: $REPO"

while IFS= read -r user
do
  echo "Agregando a $user..."
  curl -X PUT \
    -H "Authorization: Bearer $TOKEN" \
    -d '{"permission":"push"}' \
    https://api.github.com/repos/$ORG/$REPO/collaborators/$user
done < usuarios.txt

echo "Proceso completado."