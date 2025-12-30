import 'dart:convert';

class CategoryModel {
    final int? id;
    final String? name;
    final String? slug;
    final int? parent;
    final String? description;
    final Display? display;
    final Image? image;
    final int? menuOrder;
    final int? count;
    final Links? links;

    CategoryModel({
        this.id,
        this.name,
        this.slug,
        this.parent,
        this.description,
        this.display,
        this.image,
        this.menuOrder,
        this.count,
        this.links,
    });

    CategoryModel copyWith({
        int? id,
        String? name,
        String? slug,
        int? parent,
        String? description,
        Display? display,
        Image? image,
        int? menuOrder,
        int? count,
        Links? links,
    }) => 
        CategoryModel(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            parent: parent ?? this.parent,
            description: description ?? this.description,
            display: display ?? this.display,
            image: image ?? this.image,
            menuOrder: menuOrder ?? this.menuOrder,
            count: count ?? this.count,
            links: links ?? this.links,
        );

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parent: json["parent"],
        description: json["description"],
        display: displayValues.map[json["display"]]!,
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        menuOrder: json["menu_order"],
        count: json["count"],
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent": parent,
        "description": description,
        "display": displayValues.reverse[display],
        "image": image?.toJson(),
        "menu_order": menuOrder,
        "count": count,
        "_links": links?.toJson(),
    };
}

enum Display {
    DEFAULT,
    SUBCATEGORIES
}

final displayValues = EnumValues({
    "default": Display.DEFAULT,
    "subcategories": Display.SUBCATEGORIES
});

class Image {
    final int? id;
    final DateTime? dateCreated;
    final DateTime? dateCreatedGmt;
    final DateTime? dateModified;
    final DateTime? dateModifiedGmt;
    final String? src;
    final String? name;
    final String? alt;

    Image({
        this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt,
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
    };
}

class Links {
    final List<Self>? self;
    final List<Collection>? collection;
    final List<Collection>? up;

    Links({
        this.self,
        this.collection,
        this.up,
    });

    Links copyWith({
        List<Self>? self,
        List<Collection>? collection,
        List<Collection>? up,
    }) => 
        Links(
            self: self ?? this.self,
            collection: collection ?? this.collection,
            up: up ?? this.up,
        );

    factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? [] : List<Self>.from(json["self"]!.map((x) => Self.fromJson(x))),
        collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
        up: json["up"] == null ? [] : List<Collection>.from(json["up"]!.map((x) => Collection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? [] : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "up": up == null ? [] : List<dynamic>.from(up!.map((x) => x.toJson())),
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
    final List<Allow>? allow;

    TargetHints({
        this.allow,
    });

    TargetHints copyWith({
        List<Allow>? allow,
    }) => 
        TargetHints(
            allow: allow ?? this.allow,
        );

    factory TargetHints.fromRawJson(String str) => TargetHints.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TargetHints.fromJson(Map<String, dynamic> json) => TargetHints(
        allow: json["allow"] == null ? [] : List<Allow>.from(json["allow"]!.map((x) => allowValues.map[x]!)),
    );

    Map<String, dynamic> toJson() => {
        "allow": allow == null ? [] : List<dynamic>.from(allow!.map((x) => allowValues.reverse[x])),
    };
}

enum Allow {
    DELETE,
    GET,
    PATCH,
    POST,
    PUT
}

final allowValues = EnumValues({
    "DELETE": Allow.DELETE,
    "GET": Allow.GET,
    "PATCH": Allow.PATCH,
    "POST": Allow.POST,
    "PUT": Allow.PUT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
