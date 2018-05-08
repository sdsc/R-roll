#!/usr/bin/perl -w
# R roll installation test.  Usage:
# R.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $output;
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/R';

my $TESTFILE = 'tmpR';

open(OUT, ">$TESTFILE.R");
print OUT <<END;
x <- c(9, 7, 5, 3, 1, 8, 6, 4, 2, 0)
sort(x)
END
close(OUT);

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load R
R --vanilla < $TESTFILE.R
END
close(OUT);

# R-install.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'R is installed');
} else {
  ok(! $isInstalled, 'R is not installed');
}
SKIP: {

  skip 'R roll not installed', 4 if ! $isInstalled;
  $output = `/bin/bash $TESTFILE.sh 2>&1`;
  like($output, qr/0.*1.*2.*3.*4.*5.*6.*7.*8.*9/, 'Simple R run');
  $output = `module load R; /bin/echo "require('coda');(.packages())" | R --vanilla 2>&1`;
  like($output, qr/"coda"/, "coda R module loads");
  $output = `module load R; /bin/echo "require('lattice');(.packages())" | R --vanilla 2>&1`;
  like($output, qr/"lattice"/, "lattice R module loads");
  $output = `module load R; /bin/echo "require('sp');(.packages())" | R --vanilla 2>&1`;
  like($output, qr/"sp"/, "sp R module loads");

  `/bin/ls /opt/modulefiles/applications/R/[0-9]* 2>&1`;
  ok($? == 0, 'R module installed');
  `/bin/ls /opt/modulefiles/applications/R/.version.[0-9]* 2>&1`;
  ok($? == 0, 'R version module installed');
  ok(-l '/opt/modulefiles/applications/R/.version',
     'R version module link created');

} 

`rm -f $TESTFILE*`;
