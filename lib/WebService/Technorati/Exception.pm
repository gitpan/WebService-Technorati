package WebService::Technorati::Exception;
use strict;
use utf8;

use Exception::Class
        ( 'WebService::Technorati::Exception',

               'WebService::Technorati::NetworkException' =>
               { isa => 'WebService::Technorati::Exception', 
                 description => 'Indicates a network availability error' },

               'WebService::Technorati::DataException' =>
               { isa => 'WebService::Technorati::Exception',
                 description => 'Indicates a server backend availability error' },

               'WebService::Technorati::InstantiationException' =>
               { isa => 'WebService::Technorati::Exception',
                 description => 'Indicates a insufficient arguments to create class instance' },

               'WebService::Technorati::StateValidationException' =>
               { isa => 'WebService::Technorati::Exception',
                 description => 'Indicates an insufficiently populated data state' },

               'WebService::Technorati::AccessViolationException' =>
               { isa => 'WebService::Technorati::Exception',
                 description => 'Indicates access to a private attribute' },
                 
               'WebService::Technorati::MethodNotImplementedException' =>
               { isa => 'WebService::Technorati::Exception',
                 description => 'Indicates an errant method call' }

             );

1;