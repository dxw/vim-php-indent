'use strict';

var fs = require('fs')
  , child_process = require('child_process')

  , glob = require('glob')
  , async = require('async')
  , tmp = require('tmp')
  , fs2 = require('fs-extra')

function cmd(path) {
    var c = 'vim -Z -n --noplugin -i NONE -u NONE -Ec \'set smarttab shiftwidth=2|source indent/php.vim|exe "norm gg=G"|x\''
    return c + ' ' + path
}

function runVim(path, callback) {

    async.waterfall([
        function (cb) {
            tmp.file(function (err, tmpPath, fd) {
                if (err) { callback(err) }
                fs.close(fd)
                cb(null, tmpPath)
            })
        },
        function (tmpPath, cb) {
            fs2.copy(path, tmpPath, function (err) {
                if (err) { callback(err) }
                cb(null, tmpPath)
            })
        },
        function (tmpPath, cb) {
            child_process.exec(cmd(tmpPath), function (err) {
                if (err) { callback(err) }
                cb(null, tmpPath)
            })
        },
        function (tmpPath, cb) {
            cb(null, fs.readFileSync(tmpPath).toString())
        },
    ],
    function (err, output) {
        if (err) { callback(err) }
        callback(null, output)
    })

}

exports.php_indent = {
    fixtures: function (test) {
        glob(__dirname+'/fixtures/*.in.php', {}, function (err, files) {

            async.each(files, function (input, callback) {
                var output = input.replace(/\.in\.php$/, '.out.php')
                  , expectedOutput = fs.readFileSync(output).toString()

                runVim(input, function (err, actualOutput) {
                    if (err) { throw err }
                    test.equal(expectedOutput, actualOutput)
                    callback(null)
                })

            }, function (err) {
                if (err) { throw err }
                test.done()
            })

        })
    },
}
