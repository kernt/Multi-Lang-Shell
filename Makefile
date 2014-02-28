#! /usr/bin/make -f

all: help
help:
	@echo make all .................... : cette aide
	@echo make help ................... : cette aide aussi
	@echo make translate DEST_LANG=xx . : fait la traduction d\'une langue. met a jour
	@echo make cleanall ............... : enleve tous les fichiers générés.
	@echo
	@echo
	@echo exemple :
	@echo bash multilingue '#' ca lance le script en anglais.
	@echo make -f Makefile.001 translate DEST_LANG=$$LANG
	@echo bash multilingue '#' ca lance le script traduit.

BASE_NAME=multilingue
POT_FILE=$(BASE_NAME).pot

L= DLANG="$(DEST_LANG)"; DLANG=$${DLANG%.*} ;


checklang:
	@test '' != "$(DEST_LANG)" || { echo missing lang variable DEST_LANG ;\
		echo run make help for help; false ; } >&2

translate: checklang
	$L mkdir -p locale/"$$DLANG"/LC_MESSAGES 
	$L bash --dump-po-strings $(BASE_NAME) >locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po
	@echo "==============================================================="
	@echo "===  ATTENTION IL VOUS APPARTIENT D'ÉLIMINER LES DOUBLONS   ==="
	@echo "===           DANS LE FICHIER QUE VOUS ALLEZ ÉDITER.        ==="
	@echo "==============================================================="
	@echo
	@echo Appuyez sur la touche « Entrée » pour continuer.
	@read toto
	$L $${EDITOR:-$${VISUAL:-/usr/bin/editor}} locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || :
	$L msgfmt -o locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).mo locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po 


cleanall:
	rm -rf $(BASE_NAME).* *% *~ locale
#! /usr/bin/make -f

all: help
help:
	@echo make all .................... : cette aide
	@echo make help ................... : cette aide aussi
	@echo make multilingue.pot ........ : recree le fichier de chaine sources
	@echo make newlang DEST_LANG=xx ... : initialise les répertoires pour une langue
	@echo make translate DEST_LANG=xx . : fait la traduction d\'une langue. met a jour
	@echo make cleanall ............... : enleve tous les fichiers générés.
	@echo
	@echo
	@echo exemple :
	@echo bash multilingue '#' ca lance le script en anglais.
	@echo make -f Makefile.002 newlang DEST_LANG=$$LANG
	@echo make -f Makefile.002 translate DEST_LANG=$$LANG
	@echo bash multilingue '#' ca lance le script traduit.

BASE_NAME=multilingue
POT_FILE=$(BASE_NAME).pot

L= DLANG="$(DEST_LANG)"; DLANG=$${DLANG%.*} ;

$(POT_FILE): $(BASE_NAME)
	bash --dump-po-strings $(BASE_NAME) | xgettext -L PO -o $(POT_FILE) -

checklang:
	@test '' != "$(DEST_LANG)" || { echo missing lang variable DEST_LANG ;\
		echo run make help for help; false ; } >&2

newlang: checklang $(POT_FILE)
	$L mkdir -p locale/"$$DLANG"/LC_MESSAGES
	@$L test ! -r locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || { \
		echo "$La langue $$DLANG existe deja"; \
		echo "pour mettre a jour : make translate"; \
		false ; } >&2
	$L msginit -l $(DEST_LANG) -i $(POT_FILE) -o locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po

translate: checklang $(POT_FILE)
	$L test -r locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || { \
			echo did you run make newlang '?' ; false ; } >&2
	$L msgmerge -U locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po \
		multilingue.pot
	$L $${EDITOR:-$${VISUAL:-/usr/bin/editor}} locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || :
	$L msgfmt -o locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).mo locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po 


cleanall:
	rm -rf $(BASE_NAME).* *% *~ locale
#! /usr/bin/make -f

all: help
help:
	@echo make all .................... : cette aide
	@echo make help ................... : cette aide aussi
	@echo make multilingue.pot ........ : recree le fichier de chaine sources
	@echo make newlang DEST_LANG=xx ... : initialise les répertoires pour une langue
	@echo make translate DEST_LANG=xx . : fait la traduction d\'une langue. met a jour
	@echo make cleanall ............... : enleve tous les fichiers générés.
	@echo
	@echo
	@echo exemple :
	@echo bash multilingue '#' ca lance le script en anglais.
	@echo make -f Makefile.003 newlang DEST_LANG=$$LANG
	@echo make -f Makefile.003 translate DEST_LANG=$$LANG
	@echo bash multilingue '#' ca lance le script traduit.

BASE_NAME=multilingue
POT_FILE=$(BASE_NAME).pot

L= DLANG="$(DEST_LANG)"; DLANG=$${DLANG%.*} ;

$(POT_FILE): $(BASE_NAME)
	bash --dump-po-strings $(BASE_NAME) | xgettext -L PO -o $(POT_FILE) -

checklang:
	@test '' != "$(DEST_LANG)" || { echo missing lang variable DEST_LANG ;\
		echo run make help for help; false ; } >&2

newlang: checklang $(POT_FILE)
	$L mkdir -p locale/"$$DLANG"/LC_MESSAGES
	@$L test ! -r locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || { \
		echo "$La langue $$DLANG existe deja"; \
		echo "pour mettre a jour : make translate"; \
		false ; } >&2
	$L msginit -l $(DEST_LANG) -i $(POT_FILE) -o locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po

translate: checklang $(POT_FILE)
	$L test -r locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po || { \
			echo did you run make newlang '?' ; false ; } >&2
	$L msgmerge -U locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po \
		multilingue.pot
	$L poedit locale/"$$DLANG"/LC_MESSAGES/$(BASE_NAME).po

cleanall:
	rm -rf $(BASE_NAME).* *% *~ locale
