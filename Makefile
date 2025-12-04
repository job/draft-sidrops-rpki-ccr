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
	cat example.ccr | base64 | dos2unix | tr -d '\n' | par 69 > testvector.b64
	rpki-client -f example.ccr | sed 's/  //' > testvector.decode
	~/source/rfcfold/rfcfold -i testvector.decode -o testvector.decode.fold
