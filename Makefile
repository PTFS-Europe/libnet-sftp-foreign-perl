init:
	mkdir -v -p dist/

install:
	mkdir -v -p /usr/share/perl5/Net/SFTP/Foreign
	wget -qO dist/payload.tgz "https://cpan.metacpan.org/authors/id/S/SA/SALVA/Net-SFTP-Foreign-${IN_VERSION}.tar.gz"
	tar -xvf dist/payload.tgz -C dist/
	cp -v -r dist/Net-SFTP-Foreign-${IN_VERSION}/lib/Net/SFTP/Foreign/* /usr/share/perl5/Net/SFTP/Foreign/
	cp -v dist/Net-SFTP-Foreign-${IN_VERSION}/lib/Net/SFTP/Foreign.pm /usr/share/perl5/Net/SFTP/Foreign/

clean:
	rm -rvf dist/
