<jsp:useBean id="p" scope="request" type="viewmodel.BaseViewModel"/>

<footer>
    <div id="footer_left">
        <div id="footer_copyright_info">
            <p>&copy; Copyright 2019 Babbage</p>
        </div>
    </div>
    <div id="footer_center">
        <div id="footer_facebook_logo">
            <a href="#">
                <img src="${p.siteImagePath}social_facebook_logo.png" alt="footer_logo" id="footer_facebook_logo_img"/>
            </a>
        </div>
        <div id="footer_instagram_logo">
            <a href="#">
                <img src="${p.siteImagePath}social_instagram_logo.png" alt="footer_logo" id="footer_instagram_logo_img"/>
            </a>
        </div>
        <div id="footer_pinterest_logo">
            <a href="#">
                <img src="${p.siteImagePath}social_pinterest_logo.png" alt="footer_logo" id="footer_pinterest_logo_img"/>
            </a>
        </div>
        <div id="footer_twitter_logo">
            <a href="#">
                <img src="${p.siteImagePath}social_twitter_logo.png" alt="footer_logo" id="footer_twitter_logo_img"/>
            </a>
        </div>
    </div>
    <div id="footer_right">
        <div id="footer_direction_link">
            <a href="#">Directions</a>
        </div>
        <div id="footer_contact_link">
            <a href="#">Contact</a>
        </div>
        <div id="footer_privacy_link">
            <a href="#">Privacy</a>
        </div>
        <div id="footer_right_logo">
            <a href="home">
                <img src="${p.siteImagePath}logo_image_v2.png" alt="footer_logo" id="footer_right_logo_img"/>
            </a>
        </div>
    </div>
</footer>
