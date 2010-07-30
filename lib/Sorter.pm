package Sorter;

use strict;
use warnings;


sub new {
    my $proto = shift;  
    my $class = ref $proto || $proto;  
    my $self = { values => [] };  
    bless $self, $class;  
    return $self;
}


sub set_values {
    my $self = shift;
    if ( @_ ) {
        $self->{values} = [ @_ ];
    }
    return $self->{values};
}

sub get_values {
    my $self = shift;
    return @{$self->{values}};
}


sub sort {
    my $self = shift;

    sub pivot {
        my ($a, $i, $j) = @_;
        my $k = $i + 1;
        $k++ while ($k <= $j && $$a[$i] == $$a[$k]);
        return -1 if ($k > $j);
        return $i if ($$a[$i] >= $$a[$k]);
        return $k;
    }
    
    sub partition {
        my ($a, $i, $j, $x) = @_;
        my $l = $i;
        my $r = $j;
        while ($l <= $r) {
            $l++ while ($l <= $j && $$a[$l] < $x);
            $r-- while ($r >= $i && $$a[$r] >= $x);
            last if ($l > $r);
            my $t = $$a[$l];
            $$a[$l] = $$a[$r];
            $$a[$r] = $t;
            $l++;
            $r--;
        }
        return $l;
    }
    
    sub quick_sort {
        my ($a, $i, $j) = @_;
        return if ($i == $j);
        my $p = pivot($a, $i, $j);
        if ($p != -1 ) {
            my $k = partition($a, $i, $j, $$a[$p]);
            quick_sort($a, $i, $k-1);
            quick_sort($a, $k, $j);
        }
    }
    
    quick_sort($self->{values}, 0, scalar(@{$self->{values}})-1);
}

1;
