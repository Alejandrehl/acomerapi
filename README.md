# ACOMER ADMIN/API

    - Master es la rama que tiene CI con Heroku.
    - Desarrollar siempre en la rama dev, si necesitan otra rama deben sacarla desde dev.
    - Los merge a master solo se harán cuando hayan avances significativos.

# USAR RAMA DEV

    - git fetch, este comando trae todas las ramas que estan en Github.
    - git checkout -b dev, este comando permite crear localmente la rama dev y traer los cambios desde Github.
    - git pull, comando para llevar los cambios en una rama a tu entorno local.
    - git add . , comando para agregar todos los elementos modificados.
    - git commit -m "MENSAJE", comando para hacer un commit de tus cambios locales.
    - git push, comando para pushear los cambios a la rama que estas usando.
    - git merge nombreRama, comando para mezclar tu rama actual con la rama indicada como "nombreRama".

# EN CASO DE ESTAR USANDO RBENV PARA UTILIZAR DISTINTAS VERSIONES DE RUBY EN TU ENTORNO LOCAL

    - cd /projectRoute
    - rbenv global 2.5.3
    - source ~/.bash_profile
    - rails s

# COMANDOS ÚTILES

    - rails db:drop db:create db:migrate

# BRANCH

    - attentiontype tiene solo dos posibles valores (1 o 0), cuando es "1" significa que el branch es al paso y no posee mesas en caso contrario si las posee

# ESTADOS

- Los restaurantes tienen 3 estados: pending (por defecto), approved y rejected.
