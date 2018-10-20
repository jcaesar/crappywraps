project('readline', 'c', version: '6.3')

std = declare_dependency(compile_args: '-std=gnu11')

hist = ['history.c', 'histexpand.c', 'histfile.c', 'histsearch.c', 'shell.c', 'mbutil.c']
tilde = ['tilde.c']
colors = ['colors.c', 'parse-colors.c']
all = hist + tilde + colors + [
	'readline.c', 'vi_mode.c', 'funmap.c', 'keymaps.c', 'parens.c', 'search.c',
	'rltty.c', 'complete.c', 'bind.c', 'isearch.c', 'display.c', 'signals.c',
	'util.c', 'kill.c', 'undo.c', 'macro.c', 'input.c', 'callback.c', 'terminal.c',
	'text.c', 'nls.c', 'misc.c', 'xmalloc.c', 'xfree.c', 'compat.c',
]

c = meson.get_compiler('c')
config = configuration_data()
config.set_quoted('VERSION', meson.project_version())
config.set_quoted('RL_LIBRARY_VERSION', meson.project_version())
# quick unholy piece of sed:
#sed -nr "/have.*function/ { N; s/^.*have the (.*) function.*undef (.*)\$/config.set('\2', c.has_function('\1'))/p }" config.h.in
config.set('HAVE_FCNTL', c.has_function('fcntl'))
config.set('HAVE_GETPWENT', c.has_function('getpwent'))
config.set('HAVE_GETPWNAM', c.has_function('getpwnam'))
config.set('HAVE_GETPWUID', c.has_function('getpwuid'))
config.set('HAVE_ISASCII', c.has_function('isascii'))
config.set('HAVE_ISWCTYPE', c.has_function('iswctype'))
config.set('HAVE_ISWLOWER', c.has_function('iswlower'))
config.set('HAVE_ISWUPPER', c.has_function('iswupper'))
config.set('HAVE_ISXDIGIT', c.has_function('isxdigit'))
config.set('HAVE_KILL', c.has_function('kill'))
config.set('HAVE_LSTAT', c.has_function('lstat'))
config.set('HAVE_MBRLEN', c.has_function('mbrlen'))
config.set('HAVE_MBRTOWC', c.has_function('mbrtowc'))
config.set('HAVE_MBSRTOWCS', c.has_function('mbsrtowcs'))
config.set('HAVE_MEMMOVE', c.has_function('memmove'))
config.set('HAVE_PUTENV', c.has_function('putenv'))
config.set('HAVE_SELECT', c.has_function('select'))
config.set('HAVE_SETENV', c.has_function('setenv'))
config.set('HAVE_SETLOCALE', c.has_function('setlocale'))
config.set('HAVE_STRCASECMP', c.has_function('strcasecmp'))
config.set('HAVE_STRCOLL', c.has_function('strcoll'))
config.set('HAVE_STRPBRK', c.has_function('strpbrk'))
config.set('HAVE_TCGETATTR', c.has_function('tcgetattr'))
config.set('HAVE_TOWLOWER', c.has_function('towlower'))
config.set('HAVE_TOWUPPER', c.has_function('towupper'))
config.set('HAVE_VSNPRINTF', c.has_function('vsnprintf'))
config.set('HAVE_WCRTOMB ', c.has_function('wcrtomb'))
config.set('HAVE_WCSCOLL', c.has_function('wcscoll'))
config.set('HAVE_WCTYPE', c.has_function('wctype'))
config.set('HAVE_WCWIDTH', c.has_function('wcwidth'))
#sed -nr "/have.*header/ { N; s/^.*have the <(.*)> header.*undef (.*)\$/config.set('\2', c.has_header('\1'))/p }"
config.set('HAVE_DIRENT_H', c.has_header('dirent.h'))
config.set('HAVE_FCNTL_H', c.has_header('fcntl.h'))
config.set('HAVE_LANGINFO_H', c.has_header('langinfo.h'))
config.set('HAVE_LIMITS_H', c.has_header('limits.h'))
config.set('HAVE_LOCALE_H', c.has_header('locale.h'))
config.set('HAVE_MEMORY_H', c.has_header('memory.h'))
config.set('HAVE_NDIR_H', c.has_header('ndir.h'))
config.set('HAVE_PWD_H', c.has_header('pwd.h'))
config.set('HAVE_STDARG_H', c.has_header('stdarg.h'))
config.set('HAVE_STDBOOL_H', c.has_header('stdbool.h'))
config.set('HAVE_STDLIB_H', c.has_header('stdlib.h'))
config.set('HAVE_STRING_H', c.has_header('string.h'))
config.set('HAVE_STRINGS_H', c.has_header('strings.h'))
config.set('HAVE_SYS_DIR_H', c.has_header('sys/dir.h'))
config.set('HAVE_SYS_FILE_H', c.has_header('sys/file.h'))
config.set('HAVE_SYS_NDIR_H', c.has_header('sys/ndir.h'))
config.set('HAVE_SYS_PTE_H', c.has_header('sys/pte.h'))
config.set('HAVE_SYS_PTEM_H', c.has_header('sys/ptem.h'))
config.set('HAVE_SYS_SELECT_H', c.has_header('sys/select.h'))
config.set('HAVE_SYS_STREAM_H', c.has_header('sys/stream.h'))
config.set('HAVE_TERMCAP_H', c.has_header('termcap.h'))
config.set('HAVE_TERMIO_H', c.has_header('termio.h'))
config.set('HAVE_TERMIOS_H', c.has_header('termios.h'))
config.set('HAVE_UNISTD_H', c.has_header('unistd.h'))
config.set('HAVE_VARARGS_H', c.has_header('varargs.h'))
config.set('HAVE_WCHAR_H', c.has_header('wchar.h'))
config.set('HAVE_WCTYPE_H', c.has_header('wctype.h'))
# manual
config.set('HAVE_LANGINFO_CODESET', c.has_header_symbol('langinfo.h', 'nl_langinfo')?1:0)
config.set('HAVE_DECL_AUDIT_USER_TTY', c.has_header_symbol('linux/audit.h', 'AUDIT_USER_TTY')?1:0)
config.set('SPEED_T_IN_SYS_TYPES', c.has_header_symbol('sys/types.h', 'speed_t'))
config.set('HAVE_POSIX_SIGNALS', c.links('''
	#include <signal.h>
	int main() {
		sigset_t ss;
		struct sigaction sa;
		sigemptyset(&ss); sigsuspend(&ss);
		sigaction(SIGINT, &sa, (struct sigaction *) 0);
		sigprocmask(SIG_BLOCK, &ss, (sigset_t *) 0);
	}''', name: 'posix signals'
))
config.set('HAVE_BSD_SIGNALS', c.links('''
	#include <signal.h>
	int main() {
		int mask = sigmask(SIGINT);
		sigsetmask(mask); sigblock(mask); sigpause(mask);
	}''', name: 'bsd signals'
))
config.set('HAVE_USG_SIGHOLD', c.links('''
	#include <signal.h>
	int main() {
		int mask = sigmask(SIGINT);
		sigset(SIGINT, foo); sigrelse(SIGINT);
		sighold(SIGINT); sigpause(SIGINT);
	}''', name: 'USG sighold'
))
config.set('VOID_SIGHANDLER', c.compiles('''
	#include <sys/types.h>
	#include <signal.h>
	#ifdef signal
	#undef signal
	#endif
	#ifdef __cplusplus
	extern "C"
	#endif
	void (*signal ()) ();
''', name: 'void sighandler'))

tgetentdep = declare_dependency()
tgetentchk = '''
	#include <curses.h>
	#include <term.h>
	int main() { return tgetent("", ""); }
'''
if not c.links(tgetentchk)
	foreach lib: ['cursesw', 'gnutermcap', 'termcap', 'tinfo', 'curses', 'ncurses']
		libd = c.find_library(lib, required: false)
		if libd.found()
			if c.links(tgetentchk, dependencies: libd)
				tgetentdep = c.find_library(lib)
			endif
		endif
	endforeach
endif

configure_file(configuration: config, output: 'config.h') # sadly incomplete! TODO.

readline = static_library('readline', 
	sources: all,
	c_args: [ '-DHAVE_CONFIG_H', '-Werror=implicit-function-declaration' ],
)

readline_dep = declare_dependency(
	link_with: readline,
	include_directories: include_directories('.'),
	dependencies: tgetentdep,
)
