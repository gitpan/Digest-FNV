use ExtUtils::MakeMaker;
$Verbose = 1;
WriteMakefile(
    NAME    => 'Digest::FNV::fnvlib',
    SKIP    => [qw(all static_lib static dynamic_lib dynamic)],
    clean   => {'FILES' => 'libfnvlib$(LIB_EXT)'},
);

sub MY::top_targets {
    '
all :: static

pure_all :: static

static ::   libfnvlib$(LIB_EXT)

libfnvlib$(LIB_EXT): $(O_FILES)
	$(AR) cr libfnvlib$(LIB_EXT)	$(O_FILES)
	$(RANLIB) libfnvlib$(LIB_EXT)
';  
}
