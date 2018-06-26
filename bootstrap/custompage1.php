<?php /*Template Name: custompage1*/ get_header(); ?>
<!-- Header -->
<header style="text-align: center;color: #fff;padding: 50px 0 25px 0; background: #8BBC3C;" class="masthead text-white text-center" >
  <div class="container">
    <img class="img-fluid mb-5 d-block mx-auto" src="<?php echo get_template_directory_uri(); ?>/img/Logos_old/SBIHealthedlogo1.jpg" alt="">

    </br>
  </div>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>

</header>
<style media="screen">
  #page-top{
    padding-top: 4%
  }
</style>
 <section  id="page-top" <?php body_class(); ?> >

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="http://localhost:8888/wordpress/">SUB BOARD I, INC</a>
      </div>
      <a class="navbar" href="index.php">SERVICES</a>
      <a class="navbar" href="index.php">ABOUT US</a>
    </nav>

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
