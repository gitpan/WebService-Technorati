package WebService::Technorati::BaseTechnoratiObject;
use strict;
use utf8;

use vars qw($AUTOLOAD);
use AutoLoader;

use WebService::Technorati::Exception;

sub AUTOLOAD {
    my $self=shift;
    my $change=shift;
    my($type,$field)=$AUTOLOAD =~ /.*::((?:s|g)et)([A-Z]\w+)/
        || WebService::Technorati::MethodNotImplementedException->throw(
        "method not implemented: $AUTOLOAD");
    $field = lc($field);
    $self->_accessible($field)
        || WebService::Technorati::AccessViolationException->throw(
        "attribute not accessible: $field");
    if ($change && $type eq 'set') {
        $self->{$field}=$change;
    }
    return $self->{$field};
} # AUTOLOAD

sub _accessible {
	my $self = shift;
	my $class = ref($self) || $self;
	WebService::Technorati::MethodNotImplementedException->throw(
        "abstract methond '_accessible' not implemented");
}

1;

__END__
