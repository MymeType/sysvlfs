# LFS Book Conversion Tools Installation Instructions

After downloading the source, there are some things that need to be set up
on your computer if you want to convert the XML source into something easier to
read (e.g. HTML, TXT, or PDF)..

-------------------------------------------------------------------------------

If you want to convert the XML to HTML, install the following:

* libxml2: <https://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html>

* libxslt: <https://www.linuxfromscratch.org/blfs/view/svn/general/libxslt.html>

* DocBook 4.5 XML DTD: <https://www.linuxfromscratch.org/blfs/view/svn/pst/docbook.html>

* DocBook XSL Stylesheets: <https://www.linuxfromscratch.org/blfs/view/svn/pst/docbook-xsl.html>

* HTMLTidy: <https://www.linuxfromscratch.org/blfs/view/svn/general/tidy-html5.html>

-------------------------------------------------------------------------------

If you want to convert the XML to TXT, install the above items, and then install
the following:

* lynx: <https://www.linuxfromscratch.org/blfs/view/svn/basicnet/lynx.html>

-------------------------------------------------------------------------------

If you want to convert the XML to PDF, install the items listed above (except
lynx) and then install the following:

* JDK: <https://www.linuxfromscratch.org/blfs/view/svn/general/openjdk.html>

* FOP and JAI: <https://www.linuxfromscratch.org/blfs/view/svn/pst/fop.html>
