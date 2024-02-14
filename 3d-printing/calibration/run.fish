set freecad (which freecad)

# freecad main.py
freecad \
    # --console \
    --set-config RunMode=Exit \
    # --set-config ModuleFileName=main.py \
    # --set-config ScriptFileName=main.py \
    # --set-config FileName=main.py
    --set-config CopyrightInfo="" \
    -c \
    main.py