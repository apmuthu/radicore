ALTER TABLE `product` CHANGE `comment` `prod_comment` VARCHAR( 255 ) NULL DEFAULT NULL;
ALTER TABLE `inventory_item_variance` CHANGE `comment` `var_comment` TEXT NULL DEFAULT NULL ;
ALTER TABLE `prod_cat_class` CHANGE `comment` `pcc_comment` VARCHAR( 255 ) NULL DEFAULT NULL;
