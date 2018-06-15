<?php get_header(); ?>
<style media="screen">
  #page-top{
    padding-top: 4%
  }
</style>
 <section  id="page-top" <?php body_class(); ?> >
    <!-- Navigation -->
    <!-- <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="index.php">SUB BOARD I, INC</a>
      </div>
    </nav> -->

    <!-- Gets content from page from WP admin-->
    <div class = "container">
      <div class = "row" >
        <?php if(have_posts()): while (have_posts()): the_post();?>
          <div class="col-lg-12 text-center"><?php the_content(); ?> </div>
        <?php endwhile; else: ?>
        <!--  <p>Sorry, no page found.</p>-->
    <?php endif; ?>
      </div>
    </div>
</section>

<!-- Inserts footer.php -->
<?php get_footer(); ?>
