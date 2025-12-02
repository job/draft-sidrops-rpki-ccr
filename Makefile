NAME=draft-ietf-sidrops-rpki-ccr

.PHONY: all
all: drafts

.PHONY: drafts
drafts: $(NAME).txt

$(NAME).txt $(NAME).html $(NAME).exp.xml: $(NAME).xml CCR-2025.asn
	xml2rfc $(NAME).xml --html --text --expand --allow-local-file-access

www: $(NAME).txt $(NAME).html
	cp $(NAME).exp.xml ~/Downloads/
	cp $(NAME).html ~/Downloads/
	cp $(NAME).txt ~/Downloads/

upload:
	scp $(NAME).html $(NAME).txt chloe.sobornost.net:www

clean:
	rm -f *.html *.txt *.exp.xml

example:
	cat example.ccr | base64 | dos2unix | par 69 > example.b64
	rpki-client -f example.ccr > decode
	rfcfold -i decode -o folded
