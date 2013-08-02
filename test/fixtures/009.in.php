<?php

$m = new Mustache_Engine;

$s = $m->render(
  '
  <ul>
    {{^animals}}
    <li>Sorry, no animals :(</li>
    {{/animals}}
    {{#animals}}
    <li>
      {{.}}
    </li>
    {{/animals}}
  </ul>
  ',
  array(
    'animals' => array(
      'dog',
      'turtle',
      'cat',
    ),
  )
);
