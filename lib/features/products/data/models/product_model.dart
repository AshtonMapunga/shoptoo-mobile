import 'dart:convert';

class ProductModel {
    final int? id;
    final String? name;
    final String? slug;
    final String? permalink;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModified;
    final DateTime? dateModifiedGmt;
    final String? type;
    final String? status;
    final bool? featured;
    final String? catalogVisibility;
    final String? description;
    final String? shortDescription;
    final String? sku;
    final String? price;
    final String? regularPrice;
    final String? salePrice;
    final dynamic dateOnSaleFrom;
    final dynamic dateOnSaleFromGmt;
    final dynamic dateOnSaleTo;
    final dynamic dateOnSaleToGmt;
    final bool? onSale;
    final bool? purchasable;
    final int? totalSales;
    final bool? virtual;
    final bool? downloadable;
    final List<dynamic>? downloads;
    final int? downloadLimit;
    final int? downloadExpiry;
    final String? externalUrl;
    final String? buttonText;
    final String? taxStatus;
    final String? taxClass;
    final bool? manageStock;
    final dynamic stockQuantity;
    final String? backorders;
    final bool? backordersAllowed;
    final bool? backordered;
    final dynamic lowStockAmount;
    final bool? soldIndividually;
    final String? weight;
    final Dimensions? dimensions;
    final bool? shippingRequired;
    final bool? shippingTaxable;
    final String? shippingClass;
    final int? shippingClassId;
    final bool? reviewsAllowed;
    final String? averageRating;
    final int? ratingCount;
    final List<dynamic>? upsellIds;
    final List<dynamic>? crossSellIds;
    final int? parentId;
    final String? purchaseNote;
    final List<Category>? categories;
    final List<dynamic>? brands;
    final List<dynamic>? tags;
    final List<Image>? images;
    final List<dynamic>? attributes;
    final List<dynamic>? defaultAttributes;
    final List<dynamic>? variations;
    final List<dynamic>? groupedProducts;
    final int? menuOrder;
    final String? priceHtml;
    final List<int>? relatedIds;
    final List<MetaDatum>? metaData;
    final String? stockStatus;
    final bool? hasOptions;
    final String? postPassword;
    final String? globalUniqueId;
    final Store? store;
    final Links? links;

    ProductModel({
        this.id,
        this.name,
        this.slug,
        this.permalink,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.type,
        this.status,
        this.featured,
        this.catalogVisibility,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.dateOnSaleFrom,
        this.dateOnSaleFromGmt,
        this.dateOnSaleTo,
        this.dateOnSaleToGmt,
        this.onSale,
        this.purchasable,
        this.totalSales,
        this.virtual,
        this.downloadable,
        this.downloads,
        this.downloadLimit,
        this.downloadExpiry,
        this.externalUrl,
        this.buttonText,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockQuantity,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.lowStockAmount,
        this.soldIndividually,
        this.weight,
        this.dimensions,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClass,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.upsellIds,
        this.crossSellIds,
        this.parentId,
        this.purchaseNote,
        this.categories,
        this.brands,
        this.tags,
        this.images,
        this.attributes,
        this.defaultAttributes,
        this.variations,
        this.groupedProducts,
        this.menuOrder,
        this.priceHtml,
        this.relatedIds,
        this.metaData,
        this.stockStatus,
        this.hasOptions,
        this.postPassword,
        this.globalUniqueId,
        this.store,
        this.links,
    });

    ProductModel copyWith({
        int? id,
        String? name,
        String? slug,
        String? permalink,
        DateTime? dateCreated,
        DateTime? dateCreatedGmt,
        DateTime? dateModified,
        DateTime? dateModifiedGmt,
        String? type,
        String? status,
        bool? featured,
        String? catalogVisibility,
        String? description,
        String? shortDescription,
        String? sku,
        String? price,
        String? regularPrice,
        String? salePrice,
        dynamic dateOnSaleFrom,
        dynamic dateOnSaleFromGmt,
        dynamic dateOnSaleTo,
        dynamic dateOnSaleToGmt,
        bool? onSale,
        bool? purchasable,
        int? totalSales,
        bool? virtual,
        bool? downloadable,
        List<dynamic>? downloads,
        int? downloadLimit,
        int? downloadExpiry,
        String? externalUrl,
        String? buttonText,
        String? taxStatus,
        String? taxClass,
        bool? manageStock,
        dynamic stockQuantity,
        String? backorders,
        bool? backordersAllowed,
        bool? backordered,
        dynamic lowStockAmount,
        bool? soldIndividually,
        String? weight,
        Dimensions? dimensions,
        bool? shippingRequired,
        bool? shippingTaxable,
        String? shippingClass,
        int? shippingClassId,
        bool? reviewsAllowed,
        String? averageRating,
        int? ratingCount,
        List<dynamic>? upsellIds,
        List<dynamic>? crossSellIds,
        int? parentId,
        String? purchaseNote,
        List<Category>? categories,
        List<dynamic>? brands,
        List<dynamic>? tags,
        List<Image>? images,
        List<dynamic>? attributes,
        List<dynamic>? defaultAttributes,
        List<dynamic>? variations,
        List<dynamic>? groupedProducts,
        int? menuOrder,
        String? priceHtml,
        List<int>? relatedIds,
        List<MetaDatum>? metaData,
        String? stockStatus,
        bool? hasOptions,
        String? postPassword,
        String? globalUniqueId,
        Store? store,
        Links? links,
    }) => 
        ProductModel(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            permalink: permalink ?? this.permalink,
            dateCreated: dateCreated ?? this.dateCreated,
            dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
            dateModified: dateModified ?? this.dateModified,
            dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
            type: type ?? this.type,
            status: status ?? this.status,
            featured: featured ?? this.featured,
            catalogVisibility: catalogVisibility ?? this.catalogVisibility,
            description: description ?? this.description,
            shortDescription: shortDescription ?? this.shortDescription,
            sku: sku ?? this.sku,
            price: price ?? this.price,
            regularPrice: regularPrice ?? this.regularPrice,
            salePrice: salePrice ?? this.salePrice,
            dateOnSaleFrom: dateOnSaleFrom ?? this.dateOnSaleFrom,
            dateOnSaleFromGmt: dateOnSaleFromGmt ?? this.dateOnSaleFromGmt,
            dateOnSaleTo: dateOnSaleTo ?? this.dateOnSaleTo,
            dateOnSaleToGmt: dateOnSaleToGmt ?? this.dateOnSaleToGmt,
            onSale: onSale ?? this.onSale,
            purchasable: purchasable ?? this.purchasable,
            totalSales: totalSales ?? this.totalSales,
            virtual: virtual ?? this.virtual,
            downloadable: downloadable ?? this.downloadable,
            downloads: downloads ?? this.downloads,
            downloadLimit: downloadLimit ?? this.downloadLimit,
            downloadExpiry: downloadExpiry ?? this.downloadExpiry,
            externalUrl: externalUrl ?? this.externalUrl,
            buttonText: buttonText ?? this.buttonText,
            taxStatus: taxStatus ?? this.taxStatus,
            taxClass: taxClass ?? this.taxClass,
            manageStock: manageStock ?? this.manageStock,
            stockQuantity: stockQuantity ?? this.stockQuantity,
            backorders: backorders ?? this.backorders,
            backordersAllowed: backordersAllowed ?? this.backordersAllowed,
            backordered: backordered ?? this.backordered,
            lowStockAmount: lowStockAmount ?? this.lowStockAmount,
            soldIndividually: soldIndividually ?? this.soldIndividually,
            weight: weight ?? this.weight,
            dimensions: dimensions ?? this.dimensions,
            shippingRequired: shippingRequired ?? this.shippingRequired,
            shippingTaxable: shippingTaxable ?? this.shippingTaxable,
            shippingClass: shippingClass ?? this.shippingClass,
            shippingClassId: shippingClassId ?? this.shippingClassId,
            reviewsAllowed: reviewsAllowed ?? this.reviewsAllowed,
            averageRating: averageRating ?? this.averageRating,
            ratingCount: ratingCount ?? this.ratingCount,
            upsellIds: upsellIds ?? this.upsellIds,
            crossSellIds: crossSellIds ?? this.crossSellIds,
            parentId: parentId ?? this.parentId,
            purchaseNote: purchaseNote ?? this.purchaseNote,
            categories: categories ?? this.categories,
            brands: brands ?? this.brands,
            tags: tags ?? this.tags,
            images: images ?? this.images,
            attributes: attributes ?? this.attributes,
            defaultAttributes: defaultAttributes ?? this.defaultAttributes,
            variations: variations ?? this.variations,
            groupedProducts: groupedProducts ?? this.groupedProducts,
            menuOrder: menuOrder ?? this.menuOrder,
            priceHtml: priceHtml ?? this.priceHtml,
            relatedIds: relatedIds ?? this.relatedIds,
            metaData: metaData ?? this.metaData,
            stockStatus: stockStatus ?? this.stockStatus,
            hasOptions: hasOptions ?? this.hasOptions,
            postPassword: postPassword ?? this.postPassword,
            globalUniqueId: globalUniqueId ?? this.globalUniqueId,
            store: store ?? this.store,
            links: links ?? this.links,
        );

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        catalogVisibility: json["catalog_visibility"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: json["downloads"] == null ? [] : List<dynamic>.from(json["downloads"]!.map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        upsellIds: json["upsell_ids"] == null ? [] : List<dynamic>.from(json["upsell_ids"]!.map((x) => x)),
        crossSellIds: json["cross_sell_ids"] == null ? [] : List<dynamic>.from(json["cross_sell_ids"]!.map((x) => x)),
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        brands: json["brands"] == null ? [] : List<dynamic>.from(json["brands"]!.map((x) => x)),
        tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        defaultAttributes: json["default_attributes"] == null ? [] : List<dynamic>.from(json["default_attributes"]!.map((x) => x)),
        variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
        groupedProducts: json["grouped_products"] == null ? [] : List<dynamic>.from(json["grouped_products"]!.map((x) => x)),
        menuOrder: json["menu_order"],
        priceHtml: json["price_html"],
        relatedIds: json["related_ids"] == null ? [] : List<int>.from(json["related_ids"]!.map((x) => x)),
        metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
        stockStatus: json["stock_status"],
        hasOptions: json["has_options"],
        postPassword: json["post_password"],
        globalUniqueId: json["global_unique_id"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": downloads == null ? [] : List<dynamic>.from(downloads!.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "upsell_ids": upsellIds == null ? [] : List<dynamic>.from(upsellIds!.map((x) => x)),
        "cross_sell_ids": crossSellIds == null ? [] : List<dynamic>.from(crossSellIds!.map((x) => x)),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
        "default_attributes": defaultAttributes == null ? [] : List<dynamic>.from(defaultAttributes!.map((x) => x)),
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
        "grouped_products": groupedProducts == null ? [] : List<dynamic>.from(groupedProducts!.map((x) => x)),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": relatedIds == null ? [] : List<dynamic>.from(relatedIds!.map((x) => x)),
        "meta_data": metaData == null ? [] : List<dynamic>.from(metaData!.map((x) => x.toJson())),
        "stock_status": stockStatus,
        "has_options": hasOptions,
        "post_password": postPassword,
        "global_unique_id": globalUniqueId,
        "store": store?.toJson(),
        "_links": links?.toJson(),
    };
}

class Category {
    final int? id;
    final String? name;
    final String? slug;

    Category({
        this.id,
        this.name,
        this.slug,
    });

    Category copyWith({
        int? id,
        String? name,
        String? slug,
    }) => 
        Category(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class Dimensions {
    final String? length;
    final String? width;
    final String? height;

    Dimensions({
        this.length,
        this.width,
        this.height,
    });

    Dimensions copyWith({
        String? length,
        String? width,
        String? height,
    }) => 
        Dimensions(
            length: length ?? this.length,
            width: width ?? this.width,
            height: height ?? this.height,
        );

    factory Dimensions.fromRawJson(String str) => Dimensions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
    };
}

class Image {
    final int? id;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModified;
    final DateTime? dateModifiedGmt;
    final String? src;
    final String? name;
    final String? alt;
    final String? srcset;
    final String? sizes;
    final String? thumbnail;

    Image({
        this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt,
        this.srcset,
        this.sizes,
        this.thumbnail,
    });

    Image copyWith({
        int? id,
        DateTime? dateCreated,
        DateTime? dateCreatedGmt,
        DateTime? dateModified,
        DateTime? dateModifiedGmt,
        String? src,
        String? name,
        String? alt,
        String? srcset,
        String? sizes,
        String? thumbnail,
    }) => 
        Image(
            id: id ?? this.id,
            dateCreated: dateCreated ?? this.dateCreated,
            dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
            dateModified: dateModified ?? this.dateModified,
            dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
            src: src ?? this.src,
            name: name ?? this.name,
            alt: alt ?? this.alt,
            srcset: srcset ?? this.srcset,
            sizes: sizes ?? this.sizes,
            thumbnail: thumbnail ?? this.thumbnail,
        );

    factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
        dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
        dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
        dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
        srcset: json["srcset"],
        sizes: json["sizes"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated?.toIso8601String(),
        "date_created_gmt": dateCreatedGmt?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
        "srcset": srcset,
        "sizes": sizes,
        "thumbnail": thumbnail,
    };
}

class Links {
    final List<Self>? self;
    final List<Collection>? collection;

    Links({
        this.self,
        this.collection,
    });

    Links copyWith({
        List<Self>? self,
        List<Collection>? collection,
    }) => 
        Links(
            self: self ?? this.self,
            collection: collection ?? this.collection,
        );

    factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? [] : List<Self>.from(json["self"]!.map((x) => Self.fromJson(x))),
        collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? [] : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
    };
}

class Collection {
    final String? href;

    Collection({
        this.href,
    });

    Collection copyWith({
        String? href,
    }) => 
        Collection(
            href: href ?? this.href,
        );

    factory Collection.fromRawJson(String str) => Collection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class Self {
    final String? href;
    final TargetHints? targetHints;

    Self({
        this.href,
        this.targetHints,
    });

    Self copyWith({
        String? href,
        TargetHints? targetHints,
    }) => 
        Self(
            href: href ?? this.href,
            targetHints: targetHints ?? this.targetHints,
        );

    factory Self.fromRawJson(String str) => Self.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json["href"],
        targetHints: json["targetHints"] == null ? null : TargetHints.fromJson(json["targetHints"]),
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "targetHints": targetHints?.toJson(),
    };
}

class TargetHints {
    final List<String>? allow;

    TargetHints({
        this.allow,
    });

    TargetHints copyWith({
        List<String>? allow,
    }) => 
        TargetHints(
            allow: allow ?? this.allow,
        );

    factory TargetHints.fromRawJson(String str) => TargetHints.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TargetHints.fromJson(Map<String, dynamic> json) => TargetHints(
        allow: json["allow"] == null ? [] : List<String>.from(json["allow"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "allow": allow == null ? [] : List<dynamic>.from(allow!.map((x) => x)),
    };
}

class MetaDatum {
    final int? id;
    final String? key;
    final dynamic value;

    MetaDatum({
        this.id,
        this.key,
        this.value,
    });

    MetaDatum copyWith({
        int? id,
        String? key,
        dynamic value,
    }) => 
        MetaDatum(
            id: id ?? this.id,
            key: key ?? this.key,
            value: value ?? this.value,
        );

    factory MetaDatum.fromRawJson(String str) => MetaDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
    };
}

class Store {
    final int? id;
    final String? name;
    final String? shopName;
    final String? url;
    final List<dynamic>? address;
    final String? avatar;
    final String? banner;

    Store({
        this.id,
        this.name,
        this.shopName,
        this.url,
        this.address,
        this.avatar,
        this.banner,
    });

    Store copyWith({
        int? id,
        String? name,
        String? shopName,
        String? url,
        List<dynamic>? address,
        String? avatar,
        String? banner,
    }) => 
        Store(
            id: id ?? this.id,
            name: name ?? this.name,
            shopName: shopName ?? this.shopName,
            url: url ?? this.url,
            address: address ?? this.address,
            avatar: avatar ?? this.avatar,
            banner: banner ?? this.banner,
        );

    factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        shopName: json["shop_name"],
        url: json["url"],
        address: json["address"] == null ? [] : List<dynamic>.from(json["address"]!.map((x) => x)),
        avatar: json["avatar"],
        banner: json["banner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shop_name": shopName,
        "url": url,
        "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
        "avatar": avatar,
        "banner": banner,
    };
}
