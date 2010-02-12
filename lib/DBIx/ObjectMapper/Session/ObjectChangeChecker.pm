package DBIx::ObjectMapper::Session::ObjectChangeChecker;
use strict;
use warnings;
use Scalar::Util qw(refaddr);
use Data::Dumper;
use Digest::MD5 qw(md5_hex);

sub new {
    my $class = shift;
    bless {}, $class;
}

sub regist {
    my ( $self, $obj ) = @_;
    return unless $obj;
    $self->{refaddr($obj)} = $self->_hashed($obj);
}

sub is_changed {
    my ( $self, $obj ) = @_;
    return 1 unless $obj and exists $self->{refaddr($obj)};
    return $self->{refaddr($obj)} ne $self->_hashed($obj);
}

sub _hashed {
    my ( $self, $obj ) = @_;
    return unless $obj;
    local $Data::Dumper::Sortkeys = 1;
    return md5_hex(Data::Dumper::Dumper($obj));
}

1;

__END__

=head1 NAME

DBIx::ObjectMapper::Session::ObjectChangeChecker

=head1 AUTHOR

Eisuke Oishi

=head1 COPYRIGHT

Copyright 2009 Eisuke Oishi

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
