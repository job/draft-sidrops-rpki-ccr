NAME=draft-spaghetti-sidrops-rpki-ccr

.PHONY: all
all: drafts

.PHONY: drafts
drafts: $(NAME).txt

$(NAME).txt: $(NAME).xml CCR-2025.asn
	xml2rfc $(NAME).xml --html --text --expand --allow-local-file-access
	cp $(NAME).exp.xml ~/Downloads/
	cp $(NAME).html ~/Downloads/
	cp $(NAME).txt ~/Downloads/

upload:
	scp $(NAME).html $(NAME).txt chloe.sobornost.net:www

clean:
	rm -f *.html *.txt *.exp.xml
