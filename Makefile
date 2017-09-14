dots = vim tmux shell sol gitlab vmd
dotlist = $(addprefix dot-,$(dots))
installlist = $(addprefix ins-,$(dots))
home := $(shell echo $$HOME)
ln := ln -sfT
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

dot-vim:    $(home)/.vim
dot-tmux:   $(home)/.tmux.conf
dot-shell:  $(home)/.shell
dot-sol:    $(home)/.sol
dot-gitlab: $(home)/.python-gitlab.cfg
dot-vmd:    $(home)/$(vmdrc)
dot-cnf:    $(home)/.pdot.conf

python-gitlab.cfg: python-gitlab.skel pdot.conf
	@source pdot.conf; sed "s/skelplace/$$tgitlabname/g" $< > $@
	@source pdot.conf; sed "s|skelurl|$$tgitlaburl|g"  $< >> $@
	@source pdot.conf; sed "s/skeltoken/$$tgitlabtoken/g"  $< >> $@

pdot.conf: configure.sh
	@echo -e "!!!!!\nERROR: pdot.conf is outdated. Run ./configure.sh!\n!!!!!" && exit 1

$(home)/.%: %
	@$(ln) $(PWD)/$< $@ && echo "linking $@" || { echo "please backup the existing $(@) (or run make backup)" && exit 1; }

$(home)/vmd.rc: vmdrc
	$(ln) $(PWD)/$< $@

backup: backupdir/.vim backupdir/.vimrc backupdir/.tmux.conf backupdir/.shell backupdir/.shellrc backupdir/.sol backupdir/.solrc backupdir/.python-gitlab.cfg backupdir/.vmdrc backupdir/vmd.rc backupdir/.tmux

backupdir/%:
	@mkdir -p backupdir
	@mv $(home)/$* backupdir/ 2>/dev/null && echo "backing up $(home)/$*" || echo "backup: $(home)/$* not found; skipping"
