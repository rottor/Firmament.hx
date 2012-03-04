#include <hxcpp.h>

#ifndef INCLUDED_box2D_collision_B2Collision
#include <box2D/collision/B2Collision.h>
#endif
#ifndef INCLUDED_box2D_collision_B2Manifold
#include <box2D/collision/B2Manifold.h>
#endif
#ifndef INCLUDED_box2D_collision_shapes_B2CircleShape
#include <box2D/collision/shapes/B2CircleShape.h>
#endif
#ifndef INCLUDED_box2D_collision_shapes_B2Shape
#include <box2D/collision/shapes/B2Shape.h>
#endif
#ifndef INCLUDED_box2D_common_math_B2Transform
#include <box2D/common/math/B2Transform.h>
#endif
#ifndef INCLUDED_box2D_dynamics_B2Body
#include <box2D/dynamics/B2Body.h>
#endif
#ifndef INCLUDED_box2D_dynamics_B2Fixture
#include <box2D/dynamics/B2Fixture.h>
#endif
#ifndef INCLUDED_box2D_dynamics_contacts_B2CircleContact
#include <box2D/dynamics/contacts/B2CircleContact.h>
#endif
#ifndef INCLUDED_box2D_dynamics_contacts_B2Contact
#include <box2D/dynamics/contacts/B2Contact.h>
#endif
namespace box2D{
namespace dynamics{
namespace contacts{

Void B2CircleContact_obj::__construct()
{
{
	HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",31)
	super::__construct();
}
;
	return null();
}

B2CircleContact_obj::~B2CircleContact_obj() { }

Dynamic B2CircleContact_obj::__CreateEmpty() { return  new B2CircleContact_obj; }
hx::ObjectPtr< B2CircleContact_obj > B2CircleContact_obj::__new()
{  hx::ObjectPtr< B2CircleContact_obj > result = new B2CircleContact_obj();
	result->__construct();
	return result;}

Dynamic B2CircleContact_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< B2CircleContact_obj > result = new B2CircleContact_obj();
	result->__construct();
	return result;}

Void B2CircleContact_obj::reset( ::box2D::dynamics::B2Fixture fixtureA,::box2D::dynamics::B2Fixture fixtureB){
{
		HX_SOURCE_PUSH("B2CircleContact_obj::reset")
		HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",40)
		this->super::reset(fixtureA,fixtureB);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(B2CircleContact_obj,reset,(void))

Void B2CircleContact_obj::evaluate( ){
{
		HX_SOURCE_PUSH("B2CircleContact_obj::evaluate")
		HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",48)
		::box2D::dynamics::B2Body bA = this->m_fixtureA->getBody();
		HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",49)
		::box2D::dynamics::B2Body bB = this->m_fixtureB->getBody();
		HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",51)
		::box2D::collision::B2Collision_obj::collideCircles(this->m_manifold,hx::TCast< box2D::collision::shapes::B2CircleShape >::cast(this->m_fixtureA->getShape()),bA->m_xf,hx::TCast< box2D::collision::shapes::B2CircleShape >::cast(this->m_fixtureB->getShape()),bB->m_xf);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(B2CircleContact_obj,evaluate,(void))

::box2D::dynamics::contacts::B2Contact B2CircleContact_obj::create( Dynamic allocator){
	HX_SOURCE_PUSH("B2CircleContact_obj::create")
	HX_SOURCE_POS("/usr/lib/haxe/lib/box2d/1,11/box2D/dynamics/contacts/B2CircleContact.hx",33)
	return ::box2D::dynamics::contacts::B2CircleContact_obj::__new();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(B2CircleContact_obj,create,return )

Void B2CircleContact_obj::destroy( ::box2D::dynamics::contacts::B2Contact contact,Dynamic allocator){
{
		HX_SOURCE_PUSH("B2CircleContact_obj::destroy")
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(B2CircleContact_obj,destroy,(void))


B2CircleContact_obj::B2CircleContact_obj()
{
}

void B2CircleContact_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(B2CircleContact);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic B2CircleContact_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"reset") ) { return reset_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"destroy") ) { return destroy_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"evaluate") ) { return evaluate_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic B2CircleContact_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	return super::__SetField(inName,inValue);
}

void B2CircleContact_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("destroy"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("reset"),
	HX_CSTRING("evaluate"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class B2CircleContact_obj::__mClass;

void B2CircleContact_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("box2D.dynamics.contacts.B2CircleContact"), hx::TCanCast< B2CircleContact_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void B2CircleContact_obj::__boot()
{
}

} // end namespace box2D
} // end namespace dynamics
} // end namespace contacts
