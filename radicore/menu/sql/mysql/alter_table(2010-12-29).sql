USE `menu`;

ALTER TABLE `mnu_favourite` ADD `breadcrumbs` VARCHAR( 4000 ) NULL AFTER `sort_seq`;
