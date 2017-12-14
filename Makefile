dots = vim tmux shell sol gitlab vmd sncli
dotlist = $(addprefix dot-,$(dots))
installlist = $(addprefix ins-,$(dots))
home := $(shell echo $$HOME)
ln := ln -sfT
cp := cp
vmdrc = $(shell [[ "$$OSTYPE" == "cygwin" ]] && echo "vmd.rc" || echo ".vmdrc")

.SUFFIXES:

all: update

install: $(installlist)

update: git

git:
	git pull --ff-only
	+$(MAKE) install

ins-vim: dot-vim
	vim +PlugUpgrade +PlugClean! +PlugUpdate! +qall
ins-tmux: dot-tmux
ins-shell: dot-shell
	@rc=$${SHELL#*/bin/}rc ;\
	if grep -xq "^source ~/.shellrc" ~/.$$rc ; then \
        sed -i '/^source ~\/.shellrc/d' ~/.$$rc; fi
	@rc=$${SHELL#*/bin/}rc ;\
	if grep -xq "^source ~/.shell/shellrc" ~/.$$rc ; then \
	echo "shell already sources" ; else \
	echo 'source ~/.shell/shellrc' >> ~/.$$rc; fi
ins-sol: dot-sol dot-cnf
ins-gitlab: dot-gitlab
	pip install --user --upgrade python-gitlab

ins-vmd: dot-vmd

ins-sncli: dot-sncli
	pip3 install --user --upgrade git+https://github.com/urwid/urwid
	pip3 install --user --upgrade sncli

dot-vim:    $(home)/.vim
dot-tmux:   $(home)/.tmux.conf
dot-shell:  $(home)/.shell
dot-sol:    $(home)/.sol
dot-gitlab: $(home)/.python-gitlab.cfg
dot-vmd:    $(home)/$(vmdrc)
dot-cnf:    $(home)/.pdot.conf
dot-sncli:  $(home)/.snclirc

python-gitlab.cfg: python-gitlab.skel pdot_secret.conf
	@source pdot_secret.conf && sed "s/skelplace/$$tgitlabname/g; s|skelurl|$$tgitlaburl|g; s/skeltoken/$$tgitlabtoken/g" $< > $@

snclirc: snclirc.skel pdot_secret.conf
	source pdot_secret.conf && pw=$$(printf '%s\n' "$$tSimpleNotePassword" | sed 's:[\/&]:\\&:g;$$!s/$$/\\/') && sed "s/skelsnemail/$$tSimpleNoteEmail/g; s|skelsnpassword|$$pw|g" $< > $@

pdot.conf: configure.sh
	@echo -e "!!!!!\nERROR: pdot.conf is outdated. Run ./configure.sh!\n!!!!!" && exit 1

pdot_secret.conf: configure.sh
	@echo -e "!!!!!\nERROR: pdot_secret.conf is outdated. Run ./configure.sh!\n!!!!!" && exit 1

$(home)/.%: %
	@$(ln) $(PWD)/$< $@ && echo "linking $@" || { echo "please backup the existing $(@) (or run make backup)" && exit 1; }

# VMD using windows has problems with softlinks
$(home)/vmd.rc: vmdrc
	$(cp) $(PWD)/$< $@

backup: backupdir/.vim backupdir/.vimrc backupdir/.tmux.conf backupdir/.shell backupdir/.shellrc backupdir/.sol backupdir/.solrc backupdir/.python-gitlab.cfg backupdir/.vmdrc backupdir/vmd.rc backupdir/.tmux

backupdir/%:
	@mkdir -p backupdir
	@mv $(home)/$* backupdir/ 2>/dev/null && echo "backing up $(home)/$*" || echo "backup: $(home)/$* not found; skipping"
