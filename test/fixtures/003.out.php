<?php /* Template name: Case Study */ ?>
<?php the_post() ?>
<div class="container">
  <div class="row">
    <article class="span12 case-study-container">
      <div class="case-study-colour">
        <header class="row">
          <div class="title span3">
            <h2>Case study</h2>
          </div>
          <div class="span8 title">
            <h1><?php the_title(); ?></h1>
          </div>
        </header>
        <?php foreach (get_field('content_sections') as $con_secs) : ?>
          <article class="row">
            <div class="item span12">
              <div class="row">
                <div class="span3 title">
                  <?php echo $con_secs['title'] ?>
                </div>
                <div class="span9">
                  <?php echo $con_secs['content'] ?>
                </div>
              </div>
            </div>
          </article>
        <?php endforeach ?>
      </article>
    </div>
  </div>
</div>
