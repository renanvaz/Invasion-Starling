package game.utils {

    public class Extend {
       public static function get(...arguments) {
            var options, name, src, copy, copyIsArray, clone,
                target = arguments[0] || {},
                i = 1,
                length = arguments.length,
                deep = false;

            for ( ; i < length; i++ ) {
                if ( (options = arguments[ i ]) != null ) {
                    for ( name in options ) {
                        src = target[ name ];
                        copy = options[ name ];

                        if ( target === copy ) {
                            continue;
                        }

						target[ name ] = copy;
                    }
                }
            }

            return target;
        };
    }
}
