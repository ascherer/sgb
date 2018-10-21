%bcond_without tex
%bcond_without sysv
%bcond_without patches
%bcond_with debuginfo

Name: sgb
Summary: The Stanford GraphBase
License: Copyright 1993 Stanford University
URL: http://www-cs-faculty.stanford.edu/~uno/sgb.html
Packager: Andreas Scherer <https://ascherer.github.io>
Release: 21

%if %{_vendor} == "debbuild"
Version: 2:20090810
Group: math
Distribution: Kubuntu 16.04 (x86_64)
%if %{with tex}
BuildRequires: texlive
%endif
%else
Version: 20090810
Group: Productivity/Scientific/Math
Distribution: openSUSE 42 (x86_64)
%global __echo %(which echo)
%global __pdftex %(which pdftex)
%endif
BuildRoot: %{_tmppath}/%{name}-%{version}-root

Source: ftp://ftp.cs.stanford.edu/pub/sgb/%{name}.tar.gz

# Nits picked on https://www-cs-staff.stanford.edu/~knuth/sgb.html
Patch1: 0001-Nit-picked-in-2011.patch
Patch2: 0004-Nit-picked-in-2015.patch

%if %{with patches}
Patch3: 0002-GCC-complains-about-int-long-conflicts.patch
Patch4: 0003-GCC-Wformat-security.patch
Patch5: 0005-GCC-Wall.patch
Patch6: 0006-GCC-Wall-Wextra.patch
Patch7: 0007-Alternative-fix-for-GCC-5.3.1.patch
Patch8: 0008-Fix-typographic-glitch.patch
Patch9: 0009-Build-SGB-library-as-shared-object.patch
Patch10: 0010-Update-PROTOTYPES-documentation.patch
Patch11: 0011-Fix-compiler-warnings-when-optimizing.patch
%endif

%description
The Stanford GraphBase: A Platform for Combinatorial Computing.

A highly portable collection of programs and data is now available to
researchers who study combinatorial algorithms and data structures. All files
are in the public domain and usable with only one restriction: They must not be
changed! A ``change file'' mechanism allows local customization while the
master files stay intact.

%prep
%autosetup -c -p1
%{__ln_s} PROTOTYPES/*.ch .
%{?with_sysv:%{__sed} -e "s/#SYS/SYS/" -i Makefile}
%if %{with patches}
%{__sed} -e "s/CFLAGS = -g/& -Wall -Wextra/" -i Makefile
%else
%{__echo} 'demos: lib $(DEMOS)' >> Makefile
%endif
%if ! %{with debuginfo}
%{__sed} -e "s/CFLAGS = -g/CFLAGS = -O/" -i Makefile
%{__sed} -e "s/LDFLAGS =/& -s/" -i Makefile
%endif

%build
%{__make} tests demos
%{?with_tex:%{__pdftex} abstract.plaintex}

%install
%{__rm} -rf %{buildroot}
%{__install} assign_lisa book_components econ_order football girth ladders \
	miles_span multiply queen roget_components take_risc word_components \
	-D -t %{buildroot}%{_bindir}
%{__install} *.dat -m 644 -D -t %{buildroot}%{_datadir}/%{name}
%{__install} *.h -m 644 -D -t %{buildroot}%{_includedir}/%{name}
%if %{with patches}
%{__install} libgb.so -D -t %{buildroot}%{_libdir}/%{name}
%{__mkdir_p} %{buildroot}%{_sysconfdir}/ld.so.conf.d
%{__echo} "%{_libdir}/%{name}" > \
	%{buildroot}%{_sysconfdir}/ld.so.conf.d/%{name}.conf
%else
%{__install} libgb.a -m 644 -D -t %{buildroot}%{_libdir}/%{name}
%endif
%{__install} gb_types.w -m 644 -D -t %{buildroot}%{_libdir}/cweb
%{?with_tex:%{__install} abstract.pdf -m 644 -D -t %{buildroot}%{_docdir}/%{name}}

%files
%defattr(-,root,root,-)
%{_bindir}/*
%{_datadir}/%{name}/*
%{_includedir}/%{name}/*
%if %{with patches}
%{_libdir}/%{name}/libgb.so
%{_sysconfdir}/ld.so.conf.d/%{name}.conf
%else
%{_libdir}/%{name}/libgb.a
%endif
%{_libdir}/cweb/gb_types.w
%{?with_tex:%doc %{_docdir}/%{name}/*}

%post
%{?with_patches:%{__ldconfig} %{_libdir}/%{name}}

%postun
%{?with_patches:%{__ldconfig} %{_libdir}/%{name}}

%changelog
* Tue Jan 10 2017 Andreas Scherer <andreas_tex@freenet.de> 20090810-19
- Fix compiler warnings when optimizing

* Sun Dec 11 2016 Andreas Scherer <andreas_tex@freenet.de> 20090810-19
- Build SGB library as shared object

* Tue May 24 2016 Andreas Scherer <andreas_tex@freenet.de> 20090810-18
- Fix compiler warning and build on new architecture.

* Thu Nov 26 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-17
- Conditional Build Stuff.

* Thu Oct 29 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-16
- Fully parametrized specfile using tons of configuration macros.

* Mon Sep 07 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-15
- Compile with -Wall and -Wextra and fix the inflicted source modules.

* Thu Sep 03 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-14
- Compile with -Wall and fix the inflicted source modules.

* Sat Aug 15 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-13
- Provide consistent information in URL and Source.

* Mon Jul 06 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-13
- Update sgb.spec by using %setup with suitable options.

* Sat Jul 04 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-12
- GCC warns about uses of format functions that represent possible security
  problems.

* Wed Jul 01 2015 Andreas Scherer <andreas_tex@freenet.de> 20090810-11
- Update sgb.spec for new debbuild 0.10.1

* Fri Sep 02 2011 Andreas Scherer <andreas_tex@freenet.de> 20090810-10
- GCC complains about strlen and friends; set SYS=SYSV accordingly
- GCC complains about a few int/long conflicts; let's apply a patch

* Mon Aug 01 2011 Andreas Scherer <andreas_tex@freenet.de> 20090810-9
- dpkg complains about missing maintainer

* Mon Nov 23 2009 Andreas Scherer <andreas_tex@freenet.de> 20090810-8
- CWEB utilities come from TeXLive 2009 installation

* Mon Nov 09 2009 Andreas Scherer <andreas_tex@freenet.de> 20090810-7
- Update for 2009 sources

* Tue Dec 18 2007 Andreas Scherer <andreas_tug@freenet.de> 20070421-6
- Matching version number for Ubuntu/Debian

* Sat Apr 21 2007 Andreas Scherer <andreas_tug@freenet.de> 20070421-5
- Update for 2007 sources

* Fri Jun 09 2006 Andreas Scherer <andreas_tug@freenet.de> 20050329-4
- No Ubuntu, no Debian; system installation

* Thu Nov 03 2005 Andreas Scherer <andreas_tug@freenet.de> 20050329-3
- Update for 2005 sources and Debian version scheme

* Wed Nov 02 2005 Andreas Scherer <andreas_tug@freenet.de> 20030623-2
- Build from original source archive

* Sat Oct 29 2005 Andreas Scherer <andreas_tug@freenet.de> 1.0-1
- Initial build
