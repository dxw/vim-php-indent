'use strict';

module.exports = function (grunt) {
    grunt.initConfig({
        nodeunit: {
            all: ['test/*.js']
        },
        jshint: {
            gruntfile: ['Gruntfile.js'],
            tests: ['test/**/*.js'],
            options: {
                asi: true,
                laxcomma: true,

                curly: true,
                eqeqeq: true,
                immed: true,
                latedef: true,
                newcap: true,
                noarg: true,
                sub: true,
                undef: true,
                unused: true,
                boss: true,
                eqnull: true,
                node: true,
                es5: true,
            }
        },
    })

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-nodeunit');

    grunt.registerTask('test', ['jshint', 'nodeunit'])
    grunt.registerTask('default', ['test'])
}
