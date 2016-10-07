/* global module:false */
module.exports = function(grunt) {
    var port = grunt.option('port') || 8000;
    var base = grunt.option('base') || 'app';

    require('load-grunt-tasks')(grunt);

    // Project configuration
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        meta: {
            banner:
                '/*!\n' +
                ' * reveal.js <%= pkg.version %> (<%= grunt.template.today("yyyy-mm-dd, HH:MM") %>)\n' +
                ' * http://lab.hakim.se/reveal-js\n' +
                ' * MIT licensed\n' +
                ' *\n' +
                ' * Copyright (C) 2015 Hakim El Hattab, http://hakim.se\n' +
                ' */'
        },

        qunit: {
            files: [ 'app/test/*.html' ]
        },

        uglify: {
            options: {
                banner: '<%= meta.banner %>\n'
            },
            build: {
                src: 'app/js/reveal.js',
                dest: 'app/js/reveal.min.js'
            }
        },

        sass: {
            core: {
                files: {
                    'app/css/reveal.css': 'app/css/reveal.scss',
                }
            },
            themes: {
                files: [
                    {
                        expand: true,
                        cwd: 'app/css/theme/source',
                        src: ['*.scss'],
                        dest: 'app/css/theme',
                        ext: '.css'
                    }
                ]
            }
        },

        autoprefixer: {
            dist: {
                src: 'app/css/reveal.css'
            }
        },

        cssmin: {
            compress: {
                files: {
                    'app/css/reveal.min.css': [ 'app/css/reveal.css' ]
                }
            }
        },

        jshint: {
            options: {
                curly: false,
                eqeqeq: true,
                immed: true,
                latedef: true,
                newcap: true,
                noarg: true,
                sub: true,
                undef: true,
                eqnull: true,
                browser: true,
                expr: true,
                globals: {
                    head: false,
                    module: false,
                    console: false,
                    unescape: false,
                    define: false,
                    exports: false,
                    require: false,
                    process: false,
                }
            },
            files: [ 'Gruntfile.js', 'app/js/reveal.js' ]
        },

        connect: {
            server: {
                options: {
                    port: port,
                    base: base,
                    livereload: true,
                    open: true
                }
            }
        },

        zip: {
            'reveal-js-presentation.zip': [
                'app/index.html',
                'app/css/**',
                'app/js/**',
                'app/lib/**',
                'app/images/**',
                'app/plugin/**',
                'app/**.md'
            ]
        },

        watch: {
            options: {
                livereload: true
            },
            js: {
                files: [ 'Gruntfile.js', 'app/js/reveal.js' ],
                tasks: 'js'
            },
            theme: {
                files: [ 'app/css/theme/source/*.scss', 'app/css/theme/template/*.scss' ],
                tasks: 'css-themes'
            },
            css: {
                files: [ 'app/css/reveal.scss' ],
                tasks: 'css-core'
            },
            html: {
                files: [ 'app/index.html']
            },
            markdown: {
                files: [ 'app/*.md' ]
            }
        },

        copy: {
            release: {
                files: [{
                    expand: true,
                        src: [
                        'app/index.html',
                        'app/css/**',
                        'app/js/**',
                        'app/lib/**',
                        'app/images/**',
                        'app/plugin/**',
                        'app/slides/**',
                        'app/**.md'
                    ],
                    dest: 'build/',
                    filter: 'isFile'
                }],
            },
        },

        environments: {
            options: {
                local_path: 'build/app',
                current_symlink: 'current',
                deploy_path: '/var/www/sample'
            },
            production: {
                options: {
                    host: '52.212.15.110',
                    username: 'deploy',
                    privateKey: require('fs').readFileSync(process.env.BERRIART_DEPLOY_KEY),
                    port: '22',
                    releases_to_keep: '5'
                }
            }
        }

    });

    // Default task
    grunt.registerTask( 'default', [ 'css', 'js' ] );

    // JS task
    grunt.registerTask( 'js', [ 'jshint', 'uglify', 'qunit' ] );

    // Theme CSS
    grunt.registerTask( 'css-themes', [ 'sass:themes' ] );

    // Core framework CSS
    grunt.registerTask( 'css-core', [ 'sass:core', 'autoprefixer', 'cssmin' ] );

    // All CSS
    grunt.registerTask( 'css', [ 'sass', 'autoprefixer', 'cssmin' ] );

    // Package presentation to archive
    grunt.registerTask( 'package', [ 'default', 'zip' ] );

    // Build for deploy
    grunt.registerTask( 'build', [ 'default', 'copy' ] );

    // Serve presentation locally
    grunt.registerTask( 'serve', [ 'connect', 'watch' ] );

    // Run tests
    grunt.registerTask( 'test', [ 'jshint', 'qunit' ] );

    // Deploy
    grunt.registerTask('deploy', [ 'ssh_deploy:production' ]);

};
