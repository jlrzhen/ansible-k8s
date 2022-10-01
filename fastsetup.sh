ansible-playbook kube-dependencies.yml --ask-become-pass &&
ansible-playbook master.yml --ask-become-pass &&
ansible-playbook workers.yml --ask-become-pass
