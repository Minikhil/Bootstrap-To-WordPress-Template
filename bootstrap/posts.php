<!-- posts -->
<?php
  if (have_posts()): while (have_posts()): the_post();
 ?>
<div class="col-md-6 col-lg-4">
  <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-1">
    <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
      <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
        <i class="fa fa-search-plus fa-3x"></i>
      </div>
    </div>
    <?php the_post_thumbnail('full', array('class' => 'img-responsive');) ?>
    <!-- <img class="img-fluid" src="img/portfolio/cabin.png" alt=""> -->
  </a>
</div>
<?php endwhile; endif; ?>


<!-- navbar  -->
<?php
  $defaults = array(
    'container'=> 'ul',
    'theme_location'=> 'primary-menu',
    'menu_class'=> 'navbar-nav ml-auto'
  );
  wp_nav_menu( $defaults);
 ?>

<!-- Display post updated posts  -->
 <div class = "container">
   <?php if(have_posts()): while (have_posts()): the_post;?>
     <p><?php the_content(); ?></p>
   <?php endwhile; else: ?>
     <p>Sorry, no page found.</p>
   <?php endif; ?>
 </div>
