use Mojo::Base 'openQAcoretest';
use testapi;
use utils;

use OpenQA::Wheel::Launcher 'start_gui_program';

sub run {
    # Temporary workaround for AppArmor failure
    # https://progress.opensuse.org/issues/180002
    assert_script_run('systemctl stop apparmor');

    prepare_firefox_autoconfig;
    switch_to_x11;
    ensure_unlocked_desktop();
    start_gui_program('firefox http://localhost', 60, valid => 1);
    #wait few minutes for ff to start and then fail the test
    assert_screen 'openqa-dashboard', 600;
}
1;
