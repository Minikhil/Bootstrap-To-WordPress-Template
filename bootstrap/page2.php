<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <?php wp_head(); ?>

    <!-- Bootstrap core CSS -->
    <!-- <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->

    <!-- Custom styles for this template -->
    <!-- <link href="css/freelancer.min.css" rel="stylesheet"> -->

    <!-- Plugin CSS -->
    <!-- <link href="vendor/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css"> -->

    <!-- Custom fonts for this template -->
    <!-- <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">





  </head>


 <body id="page-top" <?php body_class(); ?>>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">SUB BOARD I, INC</a>
      </div>
    </nav>

    <!-- Gets content from page from WP admin-->
    <div class = "container">
      <div class = "row" >
        <?php if(have_posts()): while (have_posts()): the_post();?>
          <p><?php the_content(); ?> </p>
        <?php endwhile; else: ?>
        <!--  <p>Sorry, no page found.</p>-->
    <?php endif; ?>
      </div>
    </div>


<?php get_footer(); ?>
</body>
