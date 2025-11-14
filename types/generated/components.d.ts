import type { Schema, Struct } from '@strapi/strapi';

export interface LayoutLinkMenu extends Struct.ComponentSchema {
  collectionName: 'components_layout_link_menus';
  info: {
    displayName: 'LinkMenu';
  };
  attributes: {
    label: Schema.Attribute.String;
    url: Schema.Attribute.String;
  };
}

export interface LayoutRedeSocial extends Struct.ComponentSchema {
  collectionName: 'components_layout_rede_socials';
  info: {
    displayName: 'RedeSocial';
  };
  attributes: {
    nome: Schema.Attribute.String;
    url: Schema.Attribute.String;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'layout.link-menu': LayoutLinkMenu;
      'layout.rede-social': LayoutRedeSocial;
    }
  }
}
